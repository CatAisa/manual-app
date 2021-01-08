class Category < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '料理レシピ' },
    { id: 2, name: '作業手順' },
    { id: 3, name: '操作方法' },
    { id: 4, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :manuals
end
