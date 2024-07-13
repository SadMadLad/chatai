# frozen_string_literal: true

AI_CHATS_COUNT = 5
COVER_PICS = Dir['app/assets/images/faker/covers/*']
NORMAL_USERS_COUNT = 20
PROFILE_PICS = Dir['app/assets/images/faker/profile_pics/*']
TWO_WAY_CHATS_COUNT = 10

def generate_account_attributes(index)
  { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, role: 0, username: "#{Random.hex}#{index}" }
end

### TODO: Seed feedbacks

Rails.logger.debug 'Seeding...'

Rails.logger.debug '...Users and Accounts'

password = 'password'

admin_account_attributes = { first_name: 'Admin', last_name: 'Admin', role: 1, username: 'admin' }
admin_user = User.create(email: 'admin@admin.com', password:, account_attributes: admin_account_attributes)
admin_user.account.account_tokens.create(scope: :frontend)

super_admin_account_attributes = { first_name: 'Superadmin', last_name: 'Superadmin', role: 2, username: 'superadmin' }
super_admin_user = User.create(
  email: 'superadmin@superadmin.com',
  password:,
  account_attributes: super_admin_account_attributes
)
super_admin_user.account.account_tokens.create(scope: :frontend)

normal_users = Array.new(NORMAL_USERS_COUNT) do |i|
  { email: "user@#{i}.com", password:, account_attributes: generate_account_attributes(i) }
end

User.create(normal_users)

normal_accounts = Account.where(role: :user)
normal_accounts.each do |account|
  profile_pic = PROFILE_PICS.sample
  account.avatar.attach(
    io: File.open(Rails.root.join(profile_pic).to_s),
    filename: profile_pic
  )
end

Rails.logger.debug '...Chats and Messages'

first_account = normal_accounts.first
second_account = normal_accounts.second

last_n_accounts = normal_accounts.last(TWO_WAY_CHATS_COUNT)
first_n_accounts = normal_accounts.first(TWO_WAY_CHATS_COUNT)

chats_accounts = last_n_accounts.map { |account| [first_account, account] }
chats_accounts.each do |accounts|
  chat = Chat.create_chat(accounts)
  chat.messages.create(accounts.map { |account| { account:, content: account.full_name } })
end

4.upto 9 do |i|
  group_chat_accounts = normal_accounts.last(i) + [first_account]
  chat = Chat.create_chat(group_chat_accounts)
  chat.messages.create(group_chat_accounts.map { |account| { account:, content: Faker::Movies::TheRoom.quote } })
end

Rails.logger.debug '...AI Chats and Messages'

AI_CHATS_COUNT.times do |i|
  chat = Chat.create(chat_title: "AI Chat: #{i}", chat_type: :ai_chat, chat_status: 0)
  AccountChatMap.create(chat:, account: first_account)

  [7, 9, 12].sample.times do |j|
    chat.messages.create(role: j.even? ? :user : :assistant, content: Faker::Movies::TheRoom.quote,
                         account: j.even? ? first_account : nil)
  end
end

Rails.logger.debug '...Account Tokens for Some Accounts'

first_n_accounts.each do |account|
  account.account_tokens.create([{ scope: :frontend }, { scope: :verse }])
end

Rails.logger.debug '...Subreddits'

Subreddit.create(subreddit: 'r/rails', subreddit_url: 'https://www.reddit.com/r/rails')
Subreddit.create(subreddit: 'r/reactjs', subreddit_url: 'https://www.reddit.com/r/reactjs')

Rails.logger.debug '...Live Chats with Messages'

chat_seagal = Chat.create(chat_type: 'live_room', chat_title: 'Steven Seagal Amazing Movies', chat_description: 'Hello')
chat_breen = Chat.create(chat_type: 'live_room', chat_title: 'Breen Cadence', chat_description: 'Hello 2')
chat_seagal.photo.attach(
  io: File.open(Rails.root.join(COVER_PICS.first).to_s),
  filename: COVER_PICS.first
)
chat_breen.photo.attach(
  io: File.open(Rails.root.join(COVER_PICS.second).to_s),
  filename: COVER_PICS.second
)

[first_account, second_account].each do |account|
  chat_seagal.messages.create(account:, content: Faker::Movies::TheRoom.quote)
end

last_n_accounts.each { |account| chat_breen.messages.create(account:, content: Faker::Movies::TheRoom.quote) }

Rails.logger.debug '...Posts'

posters = normal_accounts.first(3)
account_ids = normal_accounts.pluck(:id)

posters.each_with_index do |poster, index|
  1.upto(index + 2) do |_i|
    post = Post.new(account_id: poster.id, title: Faker::Book.title,
                    body: Faker::Lorem.paragraph(sentence_count: rand(20..29)))

    random_post_images = COVER_PICS.sample(rand(1..5))
    random_post_images.each do |img|
      post.images.attach(io: File.open(Rails.root.join(img).to_s), filename: img)
    end

    post.save

    Rails.logger.debug '...Likes'

    likers = account_ids.sample Array(1..10).sample
    likes_data = likers.map { |l| { account_id: l, likeable_type: 'Post', likeable_id: post.id } }

    post.likes.create(likes_data)

    Rails.logger.debug '...Comments'

    commenters = account_ids.sample Array(1..10).sample
    commenters_data = commenters.map do |c|
      { account_id: c, commentable_type: 'Post', commentable_id: post.id, body: Faker::Movies::TheRoom.quote }
    end

    comments = post.comments.create(commenters_data)

    Rails.logger.debug '...Replies'

    comments.sample(Array(1..10).sample).each do |comment|
      reply = Comment.new(
        account_id: account_ids.sample,
        commentable_type: 'Comment',
        commentable_id: comment.id,
        body: Faker::Movies::TheRoom.quote
      )

      reply.save

      true_false = [true, false]
      should_have_reply = true_false.sample

      next unless should_have_reply

      reply_to_reply = Comment.new(
        account_id: account_ids.sample,
        commentable_type: 'Comment',
        commentable_id: reply.id,
        body: Faker::Movies::TheRoom.quote
      )

      reply_to_reply.save
    end
  end
end

Rails.logger.debug '...Tags'

books_tag = Tag.create(tag: 'Books')
education_tag = Tag.create(tag: 'Education')
economics_tag = Tag.create(tag: 'Economics')
government_tag = Tag.create(tag: 'Government')
history_tag = Tag.create(tag: 'History')
pakistan_tag = Tag.create(tag: 'Pakistan')
Tag.create(tag: 'Programming')
Tag.create(tag: 'Vocabulary')

international_relations_tag = Tag.create(tag: 'International Relations', tag_type: :meta)
pakistan_foreign_policy_tag = Tag.create(tag: 'Pakistan\'s Foreign Policy', tag_type: :meta)
pakistan_affairs_tag = Tag.create(tag: 'Pakistan\'s Affairs', tag_type: :meta)
why_nations_fail_tag = Tag.create(tag: 'Why Nations Fail', tag_type: :meta)

Rails.logger.debug '...ML Models'

ml_model = MlModel.create(
  title: 'Titanic',
  identifier: 'titanic',
  model_type: 'classification',
  description: 'Titanic Classification to see who has survived or not.',
  explanation: 'Explanation of the Machine Learning Model.',
  account: admin_user.account,
  parameters_with_order: %w[
    PassengerId
    Pclass
    Name
    Sex
    Age
    SibSp
    Parch
    Ticket
    Fare
    Cabin
    Embarked
  ]
)

Rails.logger.debug '...Prediction Params for ML Models'

prediction_params = [{ 'param_type' => 'integer', 'name' => 'PassengerId', 'description' => 'Ok',
                       'possible_values' => nil },
                     { 'param_type' => 'options', 'name' => 'Pclass', 'description' => 'ok',
                       'possible_values' => %w[3 2 1] },
                     { 'param_type' => 'text', 'name' => 'Name', 'description' => 'Name', 'possible_values' => nil },
                     { 'param_type' => 'options', 'name' => 'Sex', 'description' => 'n',
                       'possible_values' => %w[male female] },
                     { 'param_type' => 'float', 'name' => 'Age', 'description' => 'm', 'possible_values' => nil },
                     { 'param_type' => 'integer', 'name' => 'SibSp', 'description' => 'n', 'possible_values' => nil },
                     { 'param_type' => 'integer', 'name' => 'Parch', 'description' => 'm', 'possible_values' => nil },
                     { 'param_type' => 'integer', 'name' => 'Ticket', 'description' => 'm', 'possible_values' => nil },
                     { 'param_type' => 'float', 'name' => 'Fare', 'description' => 'n', 'possible_values' => nil },
                     { 'param_type' => 'string', 'name' => 'Cabin', 'description' => 'mm', 'possible_values' => nil },
                     { 'param_type' => 'options', 'name' => 'Embarked', 'description' => '321',
                       'possible_values' => %w[Q S C] }]
prediction_params = prediction_params.each { |param| param['ml_model_id'] = ml_model.id }

PredictionParam.create(prediction_params)

Rails.logger.debug '...Quizzes, its Questions and Question Options'

def seed_quiz(quiz_json_file, tags: [], give_rating: true, cover_image: nil, has_user: false, account: nil)
  quiz_data = JSON.parse Rails.root.join("app/assets/quizzes/#{quiz_json_file}.json").read
  quiz = Quiz.create(**quiz_data, account:)

  tags.each { |tag| TagMap.find_or_create_by(taggable: quiz, tag:) } if tags.present?

  if give_rating
    random_ratings_ranges = [rand(1..5), rand(3..5), rand(1..3)]
    raters = Account.where(role: :user).sample(5)
    raters.each { |rater| quiz.ratings.create(account: rater, rating: random_ratings_ranges.sample) }
  end

  if cover_image.present?
    quiz.cover.attach(
      io: Rails.root.join("app/assets/images/faker/quiz/#{cover_image}").open,
      filename: cover_image
    )
  end

  quiz.update(account: raters.sample) if has_user

  quiz
end

quiz_one_tags = [
  books_tag, international_relations_tag, education_tag, history_tag, pakistan_tag, pakistan_affairs_tag,
  pakistan_foreign_policy_tag
]
quiz_one = seed_quiz('foreign_policy_beginnings', tags: quiz_one_tags, cover_image: 'abstract-1.jpg',
                                                  account: first_account)

quiz_two_tags = [education_tag, government_tag, education_tag, pakistan_tag]
quiz_two = seed_quiz('government_of_pakistan', tags: quiz_two_tags, cover_image: 'abstract-2.jpg',
                                               account: first_account)

quiz_three_tags = [education_tag, history_tag, pakistan_tag]
quiz_three = seed_quiz('pakistan_wikipedia', tags: quiz_three_tags, give_rating: false, cover_image: 'abstract-3.jpg',
                                             account: first_account)

quiz_four_tags = [books_tag, economics_tag, education_tag, history_tag, why_nations_fail_tag]
quiz_four = seed_quiz('small_differences_and_critical_junctures_the_weight_of_history', tags: quiz_four_tags,
                                                                                        cover_image: 'abstract-4.jpg')

quiz_five_tags = [
  books_tag, international_relations_tag, education_tag, history_tag, pakistan_tag, pakistan_affairs_tag,
  pakistan_foreign_policy_tag
]
quiz_five = seed_quiz('the_kashmir_question', tags: quiz_five_tags, cover_image: 'abstract-5.jpg',
                                              account: first_account)

quiz_six_tags = [books_tag, economics_tag, education_tag, history_tag, why_nations_fail_tag]
quiz_six = seed_quiz('the_making_of_prosperity_and_poverty', tags: quiz_six_tags, account: first_account)

quizzes = [quiz_one, quiz_two, quiz_three, quiz_four, quiz_five, quiz_six]

Rails.logger.debug '...Quiz Undertakings'

def generate_quiz_undertaking(quiz, account, random_created_at: false)
  if random_created_at
    QuizUndertaking.create(quiz:, account:, score: rand(0..quiz.total_score), created_at: rand(1...100).days.ago)
  else
    QuizUndertaking.create(quiz:, account:, score: rand(0..quiz.total_score))
  end
end

quizzes.each do |quiz|
  generate_quiz_undertaking(quiz, normal_accounts.sample)
  10.times { generate_quiz_undertaking(quiz, first_account, random_created_at: true) }
end

Rails.logger.debug '...Flash Cards'

def seed_flash_cards(flash_card_json_file, account: nil)
  flash_cards = JSON.parse Rails.root.join("app/assets/flash_cards/#{flash_card_json_file}.json").read

  flash_cards.map do |flash_card_hash|
    flash_card_hash = flash_card_hash.with_indifferent_access
    tags = flash_card_hash.delete(:tags)

    flash_card = FlashCard.create(**flash_card_hash, account:)

    if tags.present?
      tags = tags.map { |tag| Tag.find_or_create_by(tag:) }
      tags.each { |tag| TagMap.create(taggable: flash_card, tag:) }
    end

    flash_card
  end
end

flash_cards = seed_flash_cards('sample', account: first_account)

Rails.logger.debug '...Collections'

flash_card_only_collection = Collection.create(account: first_account, title: 'Flash Card Collection')
quiz_only_collection = Collection.create(account: first_account, title: 'Quiz Collection')
mixed_collection = Collection.create(account: first_account, title: 'Mixed Collection')
cool_collection = Collection.create(account: first_account, title: 'Cool Collection')

collections = [flash_card_only_collection, quiz_only_collection, mixed_collection, cool_collection]

Rails.logger.debug '...Collectable Maps'

flash_cards.each do |flash_card|
  CollectableMap.create(collection: flash_card_only_collection, collectable: flash_card)
end

quizzes.each { |quiz| CollectableMap.create(collection: quiz_only_collection, collectable: quiz) }

(flash_cards.sample(2) + quizzes.sample(3)).each do |collectable|
  CollectableMap.create(collection: mixed_collection, collectable:)
end

(flash_cards.sample(2) + quizzes.sample(2) + collections.sample(2)).each do |collectable|
  CollectableMap.create(collection: cool_collection, collectable:)
end

Rails.logger.debug '...Favorites'

normal_accounts.last(6).each do |account|
  flash_cards.sample(2).each do |flash_card|
    Favorite.create(favoritable: flash_card, account:)
    Favorite.create(favoritable: flash_card, account: first_account)
  end
  quizzes.sample(4).each do |quiz|
    Favorite.create(favoritable: quiz, account:)
    Favorite.create(favoritable: quiz, account: first_account)
  end
  collections.sample(2).each do |collection|
    Favorite.create(favoritable: collection, account:)
    Favorite.create(favoritable: collection, account: first_account)
  end
end
