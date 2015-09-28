PuppetLint.new_check(:package_ensure) do
  def check
    resource_indexes.each do |resource|
      if resource[:type].value == 'package'
        attr = resource[:tokens].select { |t| t.type == :NAME && \
                                              t.value == 'ensure' && \
                                              t.next_code_token.type == :FARROW }

        next if attr.empty?
        val_token = attr[0].next_code_token.next_code_token
        next unless val_token.value == 'latest'
        next unless [:NAME, :STRING, :SSTRING].include? val_token.type
        notify :warning, {
          :message  => 'ensure set to latest on a package resource',
          :line     => val_token.line,
          :column   => val_token.column,
          :token    => val_token,
          :resource => resource
        }
      end
    end
  end

  def fix(problem)
    target_attr = problem[:resource][:tokens].select { |t| t.type == :NAME && \
                                                           t.value == 'target' && \
                                                           t.next_code_token.type == :FARROW }
    problem[:token].value = 'installed'
  end
end
