def config_path
  "#{@tmp_dir}/cucumber_lint.yml"
end


def feature_path
  "#{@tmp_dir}/features/test.feature"
end


def update_config updates
  config = YAML.load IO.read config_path
  updated_config = config.deep_merge updates
  IO.write config_path, updated_config.to_yaml
end


def write_feature content
  IO.write feature_path, content
end
