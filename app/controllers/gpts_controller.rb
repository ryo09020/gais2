class GptsController < ApplicationController
    def create
        gpt = Gpt.new(gpt_params)
        gpt.response = gpt.get_response(gpt.system, gpt.prompt)
        if gpt.save
            redirect_to gpts_path
        end
    end

    def index
        @gpts = Gpt.all
        @gpt = Gpt.new
        @pre_system = Gpt.last.system if Gpt.last.present?
    end

    def destroy_all
        Gpt.all.destroy_all
        redirect_to gpts_path
    end
    


    private

    def gpt_params
        params.require(:gpt).permit(:prompt, :system)
    end
end
