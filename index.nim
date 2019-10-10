include karax / prelude, jsutils

proc starLevel(pos, level: int): string =
  if level >= pos: return ""
  return "is-empty"

proc experience(title: string, desc: varargs[string]): VNode =
  return buildHtml tdiv(class="nes-container with-title is-rounded experience"):
    p(class="title"):
      text title
    for d in desc:
      p(class="experience-text"):
        text d

proc skill(name: string, level: int, love = false): VNode =
  return buildHtml a(class="skill"):
      tdiv:
        if love:
          span(class="nes-icon heart love")
        span(class="skill-name"):
          text name
      tdiv(class="stars"):
        span(class="nes-icon is-large star " & starLevel(1, level))
        span(class="nes-icon is-large star " & starLevel(2, level))
        span(class="nes-icon is-large star " & starLevel(3, level))
        span(class="nes-icon is-large star " & starLevel(4, level))
        span(class="nes-icon is-large star " & starLevel(5, level))

proc socialNetworks(): VNode =
  return buildHtml tdiv(class="socials"):
    a(href="https://twitter.com/kidandcat", target="_blank"):
      italic(class="nes-icon twitter")
    a(href="https://github.com/kidandcat", target="_blank"):
      italic(class="nes-icon github")
    a(href="https://linkedin.com/in/kidandcat", target="_blank"):
      italic(class="nes-icon linkedin")
    a(href="https://www.youtube.com/user/interacso", target="_blank"):
      italic(class="nes-icon youtube")
    a(href="https://keybase.io/kidandcat", target="_blank"):
      img(class="social-icon", src="keybase.png")

proc actions(): VNode =
  return buildHtml tdiv(class="actions"):
    a(class="nes-btn", href="mailto:kidandcat@gmail.com"):
      text "Email Jairo"

proc balloonClass(): string =
  if window.screen.width > 800:
    return "nes-balloon from-left"
  return "nes-balloon"

var isHard = true

proc getLevelClass(kind: string): string =
  if kind == "hard":
    if isHard:
      return "nes-btn is-error"
    return "nes-btn"
  if kind == "easy":
    if isHard:
      return "nes-btn"
    return "nes-btn is-success"

proc level(): VNode =
  return buildHtml tdiv(class="level"):
    span:
      text "Level: "
    button(class=getLevelClass("easy"), id="easy"):
      text "Easy"
      proc onclick(ev: Event; n: VNode) =
        isHard = false
        for el in document.querySelectorAll(".experience-text"):
          el.classList.add("easyfont")
    button(class=getLevelClass("hard"), id="hard"):
      text "Hard"
      proc onclick(ev: Event; n: VNode) =
        isHard = true
        for el in document.querySelectorAll(".experience-text"):
          el.classList.remove("easyfont")

proc createDom(): VNode =
  return buildHtml(tdiv(class="main")):
    tdiv(class=balloonClass(), id="saying"):
      p: 
        text "Welcome to my CV"
    tdiv(class="avatar"):
      img(src="avatar.jpg", id="avatar-img", class="nes-avatar is-large")
    tdiv(class="name"):
      span:
        text "Jairo Caro-Accino Viciana"
    actions()
    socialNetworks()
    tdiv(class="sections"):
      tdiv(class="left"):
        h3:
          italic(class="nes-icon trophy")
          text "Skills"
        tdiv(class="badges"):
          skill("react", 5)
          skill("JS", 5)
          skill("Nim", 2, true)
          skill("Go", 4)
          skill("CSS", 4)
          skill("PHP", 3)
          skill("Windows", 3)
          skill("Mac", 1)
          skill("Linux", 4)
          skill("Networking", 3)
          skill("Security", 3)
      tdiv(class="right"):
        h3:
          italic(class="nes-icon trophy")
          text "Experience"
        level()
        experience("Netelip", """
        Netelip was my first home, I had my intership there after I finished my latest studies, after 3 months of 
        intership I stayed there working, in total I spent there 1 year. My first job was to make a complex platform
        to work, it was developed in symfony, but it was unusable due to the high latency (up to 5s to do any action)
        in the frontend, the first thing I did was update to PHP7, just with that, it became much more responsive.
        """, """
        After that I introduced a real time monitoring system (which we watched on a big TV in the office), some services
        connecting with Asterisk SIP using Janus Gateway, and a VPS service with NodeJS and Proxmox.
        """, """
        I learnt a lot in Netelip, but I was ambitious, and I wanted to experiment life outside of my city, so I moved to...
        """)
        experience("Indigitall", """
        Indigitall was a startup located in Madrid, the company focused on it Push Notifications As a Service, again, my job was
        to maintain and upgrade the backend they had in PHP, Symfony too.
        """)
    footer:
      text "This website has been made with "
      img(src="nim.png")

setRenderer createDom
addStylesheet "https://unpkg.com/nes.css@latest/css/nes.min.css"
addStylesheet "https://fonts.googleapis.com/css?family=Press+Start+2P&display=swap"
addStylesheet "style.css"


