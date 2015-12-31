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

	@result_analisis = `ML/deepbelief #{save_path} ML/jetpac.ntwk | sort -r -n -k2  |head -n 4 | awk '{print $0; sum+=$2}END{printf("0\\t%f\\tothers", 1-sum)}'`
	erb :result
end

