include karax / prelude, jsutils

proc starLevel(pos, level: int): string =
  if level >= pos: return ""
  return "is-empty"

proc experience(title: string, desc: varargs[string]): VNode =
  result = buildHtml tdiv(class="nes-container with-title is-rounded experience"):
    p(class="title"):
      text title
    for d in desc:
      p:
        text d

proc skill(name: string, level: int, love = false): VNode =
  result = buildHtml a(class="skill"):
      if love:
        span(class="nes-icon heart love")
      span(class="skill-name"):
        text name
      span(class="nes-icon is-large star " & starLevel(1, level))
      span(class="nes-icon is-large star " & starLevel(2, level))
      span(class="nes-icon is-large star " & starLevel(3, level))
      span(class="nes-icon is-large star " & starLevel(4, level))
      span(class="nes-icon is-large star " & starLevel(5, level))

proc socialNetworks(): VNode =
  result = buildHtml tdiv(class="socials"):
    a(href="https://twitter.com/kidandcat", target="_blank"):
      italic(class="nes-icon twitter")
    a(href="https://github.com/kidandcat", target="_blank"):
      italic(class="nes-icon github")
    a(href="https://linkedin.com/in/kidandcat", target="_blank"):
      italic(class="nes-icon linkedin")

proc actions(): VNode =
  result = buildHtml tdiv(class="actions"):
    a(class="nes-btn", href="mailto:kidandcat@gmail.com"):
      text "Email Jairo"

proc createDom(): VNode =
  result = buildHtml(tdiv(class="main")):
    tdiv(class="name"):
      span:
        text "Jairo Caro-Accino Viciana"
    actions()
    socialNetworks()
    tdiv(class="nes-balloon from-left", id="saying"):
      p: 
        text "These are my skills"
    tdiv(class="avatar"):
      img(src="avatar.jpg", id="avatar-img", class="nes-avatar is-large")
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
    h3:
      italic(class="nes-icon trophy")
      text "Experience"
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
    Indigitall was a startup located in Madrid, and so I moved to Madrid
    """)

setRenderer createDom
addStylesheet "https://unpkg.com/nes.css@latest/css/nes.min.css"
addStylesheet "https://fonts.googleapis.com/css?family=Press+Start+2P&display=swap"
addStylesheet "style.css"


