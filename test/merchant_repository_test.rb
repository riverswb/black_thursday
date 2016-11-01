require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

    def test_merchant_repository_exists
      mr = MerchantRepository.new
      assert_equal MerchantRepository, mr.class
    end
end
