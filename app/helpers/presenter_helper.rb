module PresenterHelper
  def present(object)
    return if object.nil? || object.class.presenter.blank?
    presenter = object.class.presenter.new(object: object, view_template: self)
    yield presenter if block_given?
    presenter
  end
end
