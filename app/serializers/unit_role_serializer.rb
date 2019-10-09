# Doubtfire will deprecate ActiveModelSerializer in the future.
# Instead, write a serialize method on the model.

require 'user_serializer'

class ShallowUnitRoleSerializer < ActiveModel::Serializer
  attributes :id, :role

  def role
    object.object.role.name
  end
end

class UnitRoleSerializer < ActiveModel::Serializer
  attributes :id, :role, :user_id, :unit_id, :unit_name, :name, :unit_code, :start_date, :end_date, :teaching_period_id, :active

  # has_one :user, serializer: ShallowUserSerializer
  # has_one :unit, serializer: ShallowUnitSerializer
  # has_one :role

  def role
    object.object.role.name
  end

  def unit_id
    object.object.unit.id
  end

  def unit_code
    object.object.unit.code
  end

  def unit_name
    object.object.unit.name
  end

  def teaching_period_id
    object.object.unit.teaching_period_id
  end

  def name
    object.object.user.name
  end

  def active
    object.object.unit.active
  end

  def include_start_date?
    object.object.has_attribute? :start_date
  end

  def include_end_date?
    object.object.has_attribute? :end_date
  end

  def filter(keys)
    keys.delete :start_date unless include_start_date?
    keys.delete :end_date unless include_end_date?
    keys
  end
end

class UserUnitRoleSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :role #:user_name?

  def role
    object.object.role.name
  end

  def name
    object.object.user.name
  end

  def user_name
    object.object.user.name
  end
end
