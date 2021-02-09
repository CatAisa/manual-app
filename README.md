## usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

### Association

- has_many :manuals
- has_many :procedures
- has_many :comments
- has_many :releases
- has_many :likes
- has_many :like_manuals, through: :likes, source: :manual
- has_many :reviews

## manualsテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| title       | string     | null: false                    |
| description | text       | -                              |
| category_id | integer    | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :procedures
- has_many :comments
- has_one :release
- has_many :likes
- has_many :like_users, through: :likes, source: :user
- has_many :reviews

## proceduresテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| title       | string     | null: false                    |
| description | text       | -                              |
| manual      | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :manual
- belongs_to :user
- has_many :comments

## commentsテーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| content   | text       | -                              |
| user      | references | null: false, foreign_key: true |
| manual    | references | null: false, foreign_key: true |
| procedure | references | null: false, foreign_key: true |

### Associations

- belongs_to :user
- belongs_to :manual
- belongs_to :procedure

## releasesテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| manual | references | null: false, foreign_key: true |

### Associations

- belongs_to :user
- belongs_to :manual

## Likesテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| manual | references | null: false, foreign_key: true |

### Associations

- belongs_to :user
- belongs_to :manual

## Reviews テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | text       | -                              |
| user    | references | null: false, foreign_key] true |
| manual  | references | null: false, foreign_key: true |

### Associations

- belongs_to :user
- belongs_to :manual