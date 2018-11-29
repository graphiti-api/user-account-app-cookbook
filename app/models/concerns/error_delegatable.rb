module ErrorDelegatable
  extend ActiveSupport::Concern

  private

  def promote_errors(child_errors)
    child_errors.details.each_pair do |attribute, attr_errors|
      attr_errors.each do |e|
        errors.add(attribute, e[:error], message: e[:message])
      end
    end
  end
end