require 'sinatra' 
require 'tilt/erb'

get '/' do
	erb :index
end

# アップロード処理
post '/upload' do
	if params[:file]

		save_path = "./public/images/#{params[:file][:filename]}"

		File.open(save_path, 'wb') do |f|
			p params[:file][:tempfile]
			f.write params[:file][:tempfile].read
			@mes = "Success"
		end
	else
		@mes = "Faile"
	end

	@result_analisis = `ML/deepbelief #{save_path} ML/jetpac.ntwk | sort -r -n -k2 | awk '$2>0.000005{print $0}'`
	erb :result
end

