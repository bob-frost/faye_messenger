authorization do
  role :guest do
  end

  role :registered do
    has_permission_on :users, to: [:index]

    has_permission_on :dialogs, to: [:index, :show, :read]
    has_permission_on :messages, to: [:create]
    has_permission_on :messages, to: [:read] do
      if_attribute recipient_id: is { user.id }
    end
  end
end
