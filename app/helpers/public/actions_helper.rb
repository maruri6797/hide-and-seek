module Public::ActionsHelper
  def stamp(action)
    if params[:a]
      tag.i class: 'fa-regular fa-face-smile'
    elsif params[:b]
      tag.i class: 'fa-regular fa-face-laugh'
    elsif params[:c]
      tag.i class: 'fa-regular fa-face-laugh-beam'
    elsif params[:d]
      tag.i class: 'fa-regular fa-face-grin-wide'
    elsif params[:e]
      tag.i class: 'fa-regular fa-face-grin'
    elsif params[:f]
      tag.i class: 'fa-regular fa-face-grin-beam'
    elsif params[:g]
      tag.i class: 'fa-regular fa-face-grin-wink'
    elsif params[:h]
      tag.i class: 'fa-regular fa-face-smile-wink'
    elsif params[:i]
      tag.i class: 'fa-regular fa-face-smile-beam'
    elsif params[:j]
      tag.i class: 'fa-regular fa-face-laugh-wink'
    elsif params[:k]
      tag.i class: 'fa-regular fa-face-laugh-squint'
    elsif params[:l]
      tag.i class: 'fa-regular fa-face-grin-squint'
    elsif params[:m]
      tag.i class: 'fa-regular fa-face-grin-tongue-squint'
    elsif params[:n]
      tag.i class: 'fa-regular fa-face-grin-tongue'
    elsif params[:o]
      tag.i class: 'fa-regular fa-face-grin-tongue-wink'
    elsif params[:p]
      tag.i class: 'fa-regular fa-face-grin-tears'
    elsif params[:q]
      tag.i class: 'fa-regular fa-face-grin-stars'
    elsif params[:r]
      tag.i class: 'fa-regular fa-face-grin-squint-tears'
    elsif params[:s]
      tag.i class: 'fa-regular fa-face-rolling-eyes'
    elsif params[:t]
      tag.i class: 'fa-regular fa-face-sad-cry'
    elsif params[:u]
      tag.i class: 'fa-regular fa-face-sad-tear'
    elsif params[:v]
      tag.i class: 'fa-regular ffa-face-surprise'
    elsif params[:w]
      tag.i class: 'fa-regular fa-face-tired'
    elsif params[:x]
      tag.i class: 'fa-regular fa-face-meh-blank'
    elsif params[:y]
      tag.i class: 'fa-regular fa-face-meh'
    elsif params[:z]
      tag.i class: 'fa-regular fa-face-grin-beam-sweat'
    elsif params[:ab]
      tag.i class: 'fa-regular fa-face-grimace'
    elsif params[:cd]
      tag.i class: 'fa-regular fa-face-frown-open'
    elsif params[:ef]
      tag.i class: 'fa-regular fa-face-frown'
    elsif params[:gh]
      tag.i class: 'fa-regular fa-face-flushed'
    elsif params[:ij]
      tag.i class: 'fa-regular fa-face-dizzy'
    elsif params[:kl]
      tag.i class: 'fa-regular fa-face-angry'
    elsif params[:mn]
      tag.i class: 'fa-regular fa-face-grin-hearts'
    elsif params[:op]
      tag.i class: 'fa-regular fa-face-kiss'
    elsif params[:qr]
      tag.i class: 'fa-regular fa-face-kiss-beam'
    elsif params[:st]
      tag.i class: 'fa-regular fa-face-kiss-wink-heart'
    end
  end
end
