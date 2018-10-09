require 'rails_helper'

describe TopPageCoverImage do

  4.times do
    FactoryBot.create(:top_page_cover_image)
  end

  describe 'order_by_order_num_asc' do
    objs = TopPageCoverImage.all

    objs_sort = objs.order_by_order_num_asc
    obj_target_arr = []
    objs_sort.map { |obj| obj_target_arr << obj.order_num }

    obj_base_arr = []
    objs.map { |obj| obj_base_arr << obj.order_num }
    obj_base_arr.sort!

    it { expect(obj_target_arr).to eq obj_base_arr }
  end
end
