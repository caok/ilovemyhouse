# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password') if AdminUser.all.count == 0

Company.delete_all

Company.create!(name: "张家港我爱我家餐饮服务有限公司", contact: "许先生", tel: "18915691189", fax: "0512-58789997", qq: "252555081", address: "张家港市金港镇天台南路1栋(广和医院斜对面)", about: "张家港我爱我家餐饮服务有限公司坐落于张家港市金港镇天台南路1栋（广和医院斜对面），本企业的生存发展以及壮大关键在于人才的拥有，要留住高素质的人才为企业创造效率。公司主要经营粤菜、川菜、鲁菜、苏菜、闽菜、浙菜、湘菜、徽菜这八大菜系。 
                张家港我爱我家餐饮服务有限公司本着：诚实规范、安全、卫生、健康的经营理念，人无我有，人有我优的创业精神，以诚信、优质的经营原则，精细的规范化管理，敬业的标准化服务，已有四家分店，分别在城北路店，人民路店，德积店，港区店，生意红火，客户满意度极高。 
                相信在未来的日子里，我们能够携手同往，与时俱进，共同创造一片崭新、辉煌的天地！ ")

0.upto(14).each {|i| Dish.create!(title: "菜品名#{i}") }

0.upto(2).each {|i| New.create!(title: "测试新闻名称#{i}")}
