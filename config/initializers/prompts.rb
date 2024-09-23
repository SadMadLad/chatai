PROMPTS = YAML
            .load(
              File.read(
                Rails.root.join('config/prompts.yml')
              )
            )
            .map { |key, prompt| [key, prompt.strip] }
            .to_h
            .with_indifferent_access
