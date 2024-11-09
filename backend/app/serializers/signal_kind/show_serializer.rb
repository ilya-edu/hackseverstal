class SignalKind::ShowSerializer < BaseSerializer
  attributes :id, :name, :code, :type_of_signal, :active_ibahd, :device_kind, :controlled_parameter, :aspirator, :value_kind

  def value_kind
    ValueKind::ShortSerializer.new(object.value_kind) if object.value_kind.present?
  end

  def aspirator
    Aspirator::ShortSerializer.new(object.aspirator) if object.aspirator
  end

  def controlled_parameter
    Aspirator::ShortSerializer.new(object.controlled_parameter) if object.controlled_parameter.present?
  end

  def device_kind
    Aspirator::ShortSerializer.new(object.device_kind) if object.device_kind
  end
end
