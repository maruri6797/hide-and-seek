module Public::RoomsHelper
  def most_new_message(room)
    chat = room.chats.order(created_at: :desc).limit(1)
    chat = chat[0]
    if chat.present?
      tag.p "#{chat.message}",class: "dm_message"
    else
      tag.p "[]",class: "dm_message"
    end
  end
end

def user_name(room)
  user_room = room.user_rooms.where.not(user_id: current_user)
  name = user_room[0].user.name
  tag.p "#{name}", class: "dm_name"
end