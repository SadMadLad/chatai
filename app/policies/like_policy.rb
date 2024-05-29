class LikePolicy < ApplicationPolicy
  %w[index create].each do |action|
    define_method(:"#{action}") { true }
  end

  def destroy
    account.likes.exists?(id: record.id)
  end
end
