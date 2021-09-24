module ApplicationHelper

  def alert_class_for(flash_type)
    case flash_type.to_sym
    when :success
      "flash-success"
    when :error
      "flash-error"
    when :alert
      "flash-notice"
    when :notice
      "flash-alert"
    else
        flash_type.to_s
    end
  end
module_function :alert_class_for

  def form_errors_class(object)
    if object.send(:errors).present?
      "has-errors"
    end
  end
  def is_activated(value)
    if value
      "active"
    end
  end

  def get_to_who
    ['Derechos humanos CODICEN', 'Atención del estudiante UTU', 'Departamento Integral del Estudiante de Secundaria', 'No sé']
  end
  module_function :get_to_who
end
