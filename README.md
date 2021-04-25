## 1. Environment

* WSL(Ubuntu 20.04.1 LTS (GNU/Linux 4.19.128-microsoft-standard x86_64))
* Ruby 3.0.1p64
* Rails 6.1.3.1
* Docker version 20.10.5, build 55c4c88

## 2. Blog Post

[Automation of Botpress Accuracy Inspection Vol.3 - Rails Application -](https://oasist-blog-en.hatenablog.jp/entry/botpress_accuracy_inspection_vol3)

## 3. Boost Docker

```bash
$ docker-compose up -d
```

\* If access to `bin/rails` is denied, change permission and ignore the difference with the following commands.

```bash
$ chmod u+x bin/rails
$ git update-index --assume-unchanged bin/rails
```

## 4. Manual Documents

1. [Top Page](https://github.com/oasis-forever/botpress_inspection_tool_kit_rails/blob/master/docs/01_top.md)
2. [Learning Data Converter from CSV to JSON](https://github.com/oasis-forever/botpress_inspection_tool_kit_rails/blob/master/docs/02_json-converter.md)
3. [Matrix Chart of Confidence](https://github.com/oasis-forever/botpress_inspection_tool_kit_rails/blob/master/docs/03_converse-api.md)
4. [Deploy Botpress Server to Heroku](https://github.com/oasis-forever/botpress_inspection_tool_kit_rails/blob/master/docs/04_deploy-botpress-server-to-heroku.md)

## 5. Data Communication Chart

![Data Communication Chart](https://github.com/oasis-forever/botpress_inspection_tool_kit_rails/blob/master/public/data-communication.png)

## 6. Attention

### 6-1. Host

Call Converse API with `{Your Private IP Address}:{Port}` because Rails server in Docker container do not resolve name and cannot access with `localhost:{Port}`

### 6-2. E2E(System Spec)

If you carry out E2E test at once with `docker-compose exec app bundle exec rspec`, errors will be raised `./spec/system/converse_api_spec.rb:30` and `./spec/system/json_converters_spec.rb:17` because what downloaded file to refer to is dependent on the order of execution.  
So run seperately `docker-compose exec app bundle exec rspec ./spec/system/converse_api_spec.rb` and `docker-compose exec app bundle exec rspec ./spec/system/json_converters_spec.rb`, and they will succeed.

## 7. Production on Heroku

[Botpress Inspection Tool Kit](https://oasist-botpress-tool-kit.herokuapp.com/)
