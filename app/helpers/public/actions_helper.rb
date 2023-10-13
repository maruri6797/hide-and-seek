module Public::ActionsHelper
  def stamp(action)
    case face
    when "a" then
      tag.i class: 'fa-regular fa-face-smile'
    when "b" then
      tag.i class: 'fa-regular fa-face-laugh'
    when "c" then
      tag.i class: 'fa-regular fa-face-laugh-beam'
    when "d" then
      tag.i class: 'fa-regular fa-face-grin-wide'
    when "e" then
      tag.i class: 'fa-regular fa-face-grin'
    when "f" then
      tag.i class: 'fa-regular fa-face-grin-beam'
    when "g" then
      tag.i class: 'fa-regular fa-face-grin-wink'
    when "h" then
      tag.i class: 'fa-regular fa-face-smile-wink'
    when "i" then
      tag.i class: 'fa-regular fa-face-smile-beam'
    when "j" then
      tag.i class: 'fa-regular fa-face-laugh-wink'
    when "k" then
      tag.i class: 'fa-regular fa-face-laugh-squint'
    when "l" then
      tag.i class: 'fa-regular fa-face-grin-squint'
    when "m" then
      tag.i class: 'fa-regular fa-face-grin-tongue-squint'
    when "n" then
      tag.i class: 'fa-regular fa-face-grin-tongue'
    when "o" then
      tag.i class: 'fa-regular fa-face-grin-tongue-wink'
    when "p" then
      tag.i class: 'fa-regular fa-face-grin-tears'
    when "q" then
      tag.i class: 'fa-regular fa-face-grin-stars'
    when "r" then
      tag.i class: 'fa-regular fa-face-grin-squint-tears'
    when "s" then
      tag.i class: 'fa-regular fa-face-rolling-eyes'
    when "t" then
      tag.i class: 'fa-regular fa-face-sad-cry'
    when "u" then
      tag.i class: 'fa-regular fa-face-sad-tear'
    when "v" then
      tag.i class: 'fa-regular ffa-face-surprise'
    when "w" then
      tag.i class: 'fa-regular fa-face-tired'
    when "x" then
      tag.i class: 'fa-regular fa-face-meh-blank'
    when "y" then
      tag.i class: 'fa-regular fa-face-meh'
    when "z" then
      tag.i class: 'fa-regular fa-face-grin-beam-sweat'
    when "ab" then
      tag.i class: 'fa-regular fa-face-grimace'
    when "cd" then
      tag.i class: 'fa-regular fa-face-frown-open'
    when "ef" then
      tag.i class: 'fa-regular fa-face-frown'
    when "gh" then
      tag.i class: 'fa-regular fa-face-flushed'
    when "ij" then
      tag.i class: 'fa-regular fa-face-dizzy'
    when "kl" then
      tag.i class: 'fa-regular fa-face-angry'
    when "mn" then
      tag.i class: 'fa-regular fa-face-grin-hearts'
    when "op" then
      tag.i class: 'fa-regular fa-face-kiss'
    when "qr" then
      tag.i class: 'fa-regular fa-face-kiss-beam'
    when "st" then
      tag.i class: 'fa-regular fa-face-kiss-wink-heart'
    end
  end
end
