class TeachersImporter

  def initialize(filename=File.absolute_path('db/data/teachers.csv'))
    @filename = filename
  end

  def import
    field_names = ['name', 'email', 'address', 'phone']
    puts "Importing teachers from '#{@filename}'"
    failure_count = 0
    Teacher.transaction do
      File.open(@filename).each do |line|
        data = line.chomp.split(',')
        attribute_hash = Hash[field_names.zip(data)]
        begin
          Teacher.create!(attribute_hash)
          print '.'
        rescue ActiveRecord::UnknownAttributeError
          failure_count += 1
          print '!'
        ensure
          STDOUT.flush
        end
      end
    end
    failures = failure_count > 0 ? "(failed to create #{failure_count} teacher records)" : ''
    puts "\nDONE #{failures}\n\n"
  end

end


  # Teacher.create({name: "Jennifer Tigner", email: "jennifertigner@gmail.com", address: "905 E 15th Ave", phone: "111-1111"})
  # Teacher.create({name: "Garrett Paul", email: "g_funk222@hotmail.com", address: "1005 McKenzie Ave", phone: "222-2222"})
  # Teacher.create({name: "Rachel Tigner", email: "racheltigner@gmail.com", address: "1234 South Korea", phone: "333-3333"})
  # Teacher.create({name: "Trevor Tigner", email: "trevortigner@gmail.com", address: "456 Ottawa", phone: "444-4444"})
  # Teacher.create({name: "Laksh K", email: "laksh@gmail.com", address: "128 Launch Academy", phone: "555-5555"})
  # Teacher.create({name: "Theo Theo", email: "theotheo@gmail.com", address: "Academy de Launch", phone: "666-6666"})
  # Teacher.create({name: "Elly Longridge", email: "elly@hotmail.com", address: "905 E 15th Ave", phone: "777-7777"})
  # Teacher.create({name: "Lauren Tee", email: "lauren@tee.com", address: "Somewhere in Vancouver", phone: "888-8888"})
  # Teacher.create({name: "Reinhardt Rein", email: "reinhardt@school.com", address: "Launch Vancouver", phone: "999-9999"})