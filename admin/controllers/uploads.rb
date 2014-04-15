Lenstroy::Admin.controllers :uploads do
  post 'images', csrf_protection: true do
    answer = UploadedImage.store params[:file]
    answer.to_json
  end

  get 'images/imagelist', provides: :json do
    UploadedImage.imagelist.to_json
  end
end
