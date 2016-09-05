task :mutant do
  vars = 'NOCOVERAGE=true'
  flags = '--include lib --use rspec'
  unless system("#{vars} mutant #{flags} GovukPayApiClient*")
    raise 'Mutation testing failed'
  end
end

task(:default).prerequisites << task(:mutant)

