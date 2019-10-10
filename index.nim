include karax / prelude, jsutils

proc starLevel(pos, level: int): string =
  if level >= pos: return ""
  return "is-empty"

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
    tdiv(class="nes-balloon from-left", id="saying"):
      p: 
        text "These are my skills"
    tdiv(class="avatar"):
      img(src="avatar.jpg")
    tdiv(class="name"):
      span:
        text "Jairo Caro-Accino Viciana"
    socialNetworks()
    actions()
    tdiv(class="badges"):
      skill("react", 5)
      skill("JS", 5)
      skill("Nim", 2, true)
      skill("Go", 4)
      skill("CSS", 4)
      skill("PHP", 3)
      skill("Windows", 3)
      skill("Mac", 0)
      skill("Linux", 4)
      skill("Networking", 3)
      skill("Security", 3)

setRenderer createDom
addStylesheet "https://unpkg.com/nes.css@latest/css/nes.min.css"
addStylesheet "https://fonts.googleapis.com/css?family=Press+Start+2P&display=swap"
addStylesheet "style.css"


