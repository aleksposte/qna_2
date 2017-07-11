class Attachment < ApplicationRecord
  belongs_to :attachable, polimorphic: true, optional: true
  validate :file, presence: true
  mount_uploader :file, FileUploader
end