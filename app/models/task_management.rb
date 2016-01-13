class TaskManagement < ActiveRecord::Base
   belongs_to :taskees, class_name: "User"
   belongs_to :taskers, class_name: "User"
end
