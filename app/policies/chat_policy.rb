class ChatPolicy < ApplicationPolicy
  def index?
    true
  end

  def group?
    true
  end

  def show?
    account.chats.exists?(id: record.id)
  end

  def create?
    true
  end

  def destroy?
    account.chats.exists?(id: record.id)
  end
end
