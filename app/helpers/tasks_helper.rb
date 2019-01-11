# frozen_string_literal: true

module TasksHelper
  def label_catcher
    label_data = Task.includes(:stuck_labels).all.where(user_id: current_user.id)
    label = []
    label_data.each do |task|
      next unless task.stuck_labels.present?

      la = task.stuck_labels
      la.each do |l|
        label << l.name
      end
      @check = label.uniq
    end
    @check = [''] if @check.nil?
    @check
  end
end
