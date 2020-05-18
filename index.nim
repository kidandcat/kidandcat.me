include karax / prelude
import jsutils, dom, jsffi

proc upupStart(config: JsObject) {.importcpp:"UpUp.start(#)".}

proc upup() =
  upupStart(JsObject{
    "cache-version": cstring"v1",
    "content-url": cstring"/index.html",
    "assets": [
      cstring"/index.html",
      cstring"/index.js",
      cstring"/style.css",
      cstring"/upup.min.js",
      cstring"/kongtext.ttf",
      cstring"/interacso.png",
      cstring"/avatar.jpg",
      cstring"/nim.png",
    ]
  })

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

proc skill(name: string, level: int, love = false, dislike = false): VNode =
  return buildHtml a(class="skill"):
      tdiv:
        if love:
          span(class="nes-icon heart love")
        span(class="skill-name"):
          text name
          if dislike:
            span(class="nes-icon is-large like")
      tdiv(class="stars"):
        span(class="nes-icon star " & starLevel(1, level))
        span(class="nes-icon star " & starLevel(2, level))
        span(class="nes-icon star " & starLevel(3, level))
        span(class="nes-icon star " & starLevel(4, level))
        span(class="nes-icon star " & starLevel(5, level))

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
          skill("React", 5)
          skill("Svelte", 5, true)
          skill("React Native", 4)
          skill("JS", 5)
          skill("Nim", 3, true)
          skill("Go", 5, true)
          skill("CSS", 5)
          skill("PHP", 3)
          skill("Elixir", 2, true)
          skill("Windows", 3)
          skill("Mac", 1)
          skill("Linux", 5)
          skill("Networking", 4)
          skill("Security", 3)
          skill("Caddy", 3)
          skill("Apache", 2, false, true)
          skill("Nginx", 3, false, true)
          skill("C#", 1, false, true)
          skill("Java", 3, false, true)
          skill("Erlang", 1, false, true)
          skill("Kotlin", 1, false, true)
          skill("Dart", 1, false, true)
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
        Indigitall is a startup located in Madrid, the company focused on its Push Notifications As a Service, again, my job was
        to maintain and upgrade the backend they had in PHP, Symfony toom and I managed the servers too.
        """, """
        What I learnt the most here was to interact with clients. Because we where just 3 people, and we had big clients, I
        had to email with clients, go to their offices, etc.
        """, """
        We had some interesting performance challenges, when Orange became a client, we instantly had 2 to send push notifications
        to two million users, that was fun.
        """, """
        Although I was very happy here, I was not happy with the lifestyle in Madrid, and our house was too small, and the big distances!
        Finally a chance to come back to Málaga knocked my door, and in less than 2 weeks, I was back in Málaga.
        """)
        experience("Accenture", """
        My next adventure was in Accenture, this time I was contracted as Frontend Developer with React experience. I was happy to be
        able to experience working in a big company. I learnt what bureaucracy is, big offices, a lot of people, and very big development
        teams. It was interesting, I received a very good course from lemoncode.net about React + Redux-Observables. But once again, it was
        not what I was looking for.
        """, """
        In a short time, few months, I saw myself wasting my time, spending hours and hours doing non-sense burocracy and I was not learning
        anything new (at least programming related, I keep learning a lot of things about the company itself).
        """, """
        Finally, most of my mates leaved, and I did it too. Being in Málaga again, there where a lot of possibilities near me.
        """)
        experience("Algorath", """
        Algorath was a startup with just 3 people, placed next to the university of Málaga. I worked here coding mainly in Go. It was my first 
        experience working with Go with an experienced team.
        """, """
        We worked together with an england company, Yoti, developing a distributed ledger to manage identities. I learnt a lot about Go and
        well practices thanks to very good and experienced people [thanks Piers ;)]. After a few months I was in charge of developing a
        mobile app using Go Mobile + React Native, we managed to launch a node of the ledger inside the phone.
        """, """
        My experience in Algorath was very confortable, and I learnt a lot. I'm grateful for the time I spent there. But finally, one more chance
        came to me. The chance of remote working...
        """)
        experience("Interacso", """
        Interacso is my current company, I've been working here for a full year now (that's a new thing to me). I closed the contract and start 
        working remotely without even visiting my company office. After few months, I went to Madrid to meet my mates in person.
        """, """
        Here in Interacso I develop mostly frontend with React, any kind of frontend. Mobile apps, desktop apps, browser apps, and even IoT apps. 
        I have tons of challenges nearly every week. I have awesome mates and leaders. And also to be able to live
        anywhere I want, and to manage my time are things I will have it hard to say goodbay to.
        """, """
        I'm so happy in Interacso that this year has passed very quickly to me.
        """)
    footer:
      text "This website has been made with "
      img(src="nim.png")

addScript "upup.min.js"
setRenderer createDom
addStylesheet "https://unpkg.com/nes.css@latest/css/nes.min.css"
addStylesheet "https://fonts.googleapis.com/css?family=Press+Start+2P&display=swap"
addStylesheet "style.css"
document.title = "Jairo Caro-Accino Viciana"


discard setTimeout(proc() =
  upup()
, 2000)