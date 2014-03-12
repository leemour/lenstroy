Lenstroy::Admin.controllers :upload do
  post 'images', csrf_protection: false do
    answer = UploadedImage.store params[:file]
    answer.to_json
  end

  get 'images/imagelist', provides: :json do
    UploadedImage.imagelist.to_json
  end
end
