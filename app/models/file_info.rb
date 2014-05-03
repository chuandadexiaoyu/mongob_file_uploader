class FileInfo
  include Mongoid::Document

  belongs_to :user

  mount_uploader :any_file, AnyFileUploader
end
