# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
CourseCategory.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!(CourseCategory.table_name)
CourseCategory.create([
    { category: "kismama", title: "First aid course for new parents" },
    { category: "ujraelesztes", title: "Resuscitation course" },
    { category: "otthonapolas", title: "First aid course for home carers" },
    { category: "alapszint", title: "First aid 1" },
    { category: "ugyelet", title: "Being on duty at an event", prerequisite_course_category_id: 4 },
    { category: "emeltszint", title: "First aid 2", prerequisite_course_category_id: 5},
])
