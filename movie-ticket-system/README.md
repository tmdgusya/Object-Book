# Ruby 로 영화 예메 시스템 만들기

Ruby 도 객체 지향언어이고, 객체지향 프로그래밍을 하기 좋은 언어이다.
Rails 라는 좋은 웹 프레임워크도 있으니, Ruby 를 경험하고 싶다면 경험해보기를 바란다!

## 객체?

객체란 **상태(STATUS) 와 BEHAVIOR(행위) 를 가지고 있는 주체**를 말한다고 생각한다.
즉 해당 **객체 내에서의 STATUS 의 변경 / 수정 / 삭제는 오로지 주체의 행위에 의해서만 간섭받을 수 있다.**

그렇다면 클래스는 무엇일까? 

## 클래스?

내 생각에 **클래스란 객체를 추상화 시킨 설계도**라고 생각한다.
즉 핸드폰이 뭐 **전화걸기(행위), 전화번호(상태)... 등등을 가지고 있으면 클래스는 아래와 같은 형태**가 될것이다.
```ruby

class Phone

  def initialize(number)
    @number = number
  end
  
  def call_to(number)
    # call to number
  end
end
```

즉 이러한 방법으로 추상화 시켜놓고, 객체로 만들어 사용하는 것이다. 
사용하는 도중(런타임) 에 주체의 행위에 의해 해당값이 바뀔 수도 있다.

서론은 여기까지 간략하게 다루고, **그렇다면 객체지향 프로그래밍은 무엇일까?**

## 객체지향 프로그래밍

**객체지향 프로그래밍이란, 모든 관점을 객체적으로 생각하여 프로그래밍을 하는 것**을 뜻한다. 
즉 프로그래밍의 **시작부터 끝까지 오로지 객체**인것이다.
그렇기 때문에 **모든 비즈니스 로직은 객체간의 메세지를 주고 받으며 이루어진다.**

그렇다면 영화 예매 프로젝트를 만들어본다고 해보자.

일단 클래스 도식도를 보면서 설명하려고 한다.

![image](https://user-images.githubusercontent.com/57784077/129924590-d94d4b7b-d464-4197-a84b-6c76bc7dc17d.png)

일단 **영화의 비용을 구하는데는 여러가지 요인들이 작용한다. 예를 들면, 할인 정책을 적용해야 한다는 등등..**

**그래서 할인 정책에 해당하는 내용들은 DiscountPolicy 라는 클래스로 추상화 시켰다.**
우리가 가지고 있는 할인정책은 아래와 같다.

- **단순한 가격 할인정책**
  - 할인할 가격을 넣어주면 그 가격만큼 빼진다.
- **퍼센티지 할인 정책**
  - 몇 퍼센티지인지를 넣어주면 그 가격만큼 할인된다.

**할인 조건**은 아래와 같다
- 해당 날짜의 **할인 시간안에 영화가 시작된다면 할인(period_condition)**
- 순번 할인제는 **영화가 3번째 순번으로 시작된다면 할인해주는 조건**이다.

그렇다면 우리는 이를 코드로 짜보도록 하자

**일단 영화는 제목(title), 상영시간(running_time), fee(기본_가격), discount_policy(할인정책)** 을 가진다.

따라서 우리가 할인 정책이 포함된 영화의 가격을 알기위해서는 caculate_money_fee 메소드를 호출하면 된다.
그렇다면 클래스는 아래와 같을 것이다.

```ruby
class Movie
  attr_reader :title, :running_time, :fee, :discount_policy

  def initialize(title, running_time, fee, discount_policy)
    @title = title
    @running_time = running_time
    @fee = fee
    @discount_policy = discount_policy
  end

  public def calculate_money_fee(screening)
    if @discount_policy.nil?
      return @fee
    end
    fee.minus(@discount_policy.calculate_discount_amount(screening))
  end

end
```

우리는 **이 클래스에서 적용된 할인정책(@discount_policy)** 를 통해서 가격이 계산된다는 것을 알 수 있다.

**할인정책은 그렇다면 위의 설계도 대로 짠다고 했을때, 할인 금액 계산과, 총 할인되는 금액을 계산하는 함수를 가지고 있을 것**이다.

```ruby
class DiscountPolicy

  def initialize(conditions)
    @conditions = conditions
  end

  public def calculate_discount_amount(screening)
    @conditions.each do |discount_policy|
      if discount_policy.is_satisfied?(screening)
        return get_discount_amount(screening)
      end
    end

    # 0원임을 의미하는 함수
    return Money::UNIT::ZERO 
  end

  #interface
  def get_discount_amount(screening)
    raise RuntimeError("Plz implement that")
  end

end
```

위와 같은 형태를 지니고 있을 것이다.

calculate_discount_amount 함수가 실행되면, 
해당 정책이 가지고 있는 **@conditions 을 루프처럼 돌며 is_satisfied? 를 실행한다. 
즉 할인조건에 만족한다면 할인되야 할 금액을 리턴**한다.

get_discount_amount 는 추상메소드 이다. 따라서 구현체에서 구현하여야 한다.

```ruby
class AmountDiscountPolicy < DiscountPolicy

  def initialize(conditions, discount_amount)
    super(conditions)
    @discount_amount = discount_amount
  end

  def get_discount_amount(screening)
    @discount_amount
  end

end
```

```ruby
class PercentDiscountPolicy < DiscountPolicy

  def initialize(conditions, percent)
    super(conditions)
    @percent = percent
  end

  def get_discount_amount(screening)
    screening.get_movie_fee / @percent
  end

end
```

위와 같은 형태가 될것이다.
그렇다면 **우리의 할인 조건은 두개가 있었다. 기간 조건과, 순번조건 해당 내용을 구현**해보자
이거 또한 **할인조건이므로 할인조건이 만족하는지만 확인하면 된다. 따라서 만족하는가? 를 추상화 시키자.**

```ruby
module DiscountCondition

  #interface
  def is_satisfied?(screening)
    raise RuntimeError("Plz Implement this func")
  end

end
```

```ruby
class PeriodCondition
  include DiscountCondition

  def initialize(day_of_week, start_time, end_time)
    @day_of_week = day_of_week
    @start_time = start_time
    @end_time = end_time
  end

  def is_satisfied?(screening)
    screening.when_screened == @day_of_week and @start_time < screening.start_time and @end_time > screening.start_time
  end

end
```

```ruby
class SequenceCondition
  include DiscountCondition

  def initialize(sequence)
    @sequence = sequence
  end

  def is_satisfied?(screening)
    screening.is_sequence?(@sequence)
  end

end
```
위와 같은 형태로 구현할 수 있을 것이다.
이 상태에서 다시 한번 할인정책의 메소드를 보자

```ruby
  public def calculate_discount_amount(screening)
    @conditions.each do |discount_policy|
      if discount_policy.is_satisfied?(screening)
        return get_discount_amount(screening)
      end
    end

    return Money::UNIT::ZERO
  end
```

이제 우리가 만약 할인정책을 추가한다면, 
is_satisfied? 를 구현한 할인정책만 추가하게 된다면 우리는 비슷한 관심사로 모아볼 수 있을 것이다.
따라서 해당코드를 실행시키기 위해서는 아래와 같이 실행할 것이다.

- 할인 10퍼센트를 적용한 코드이다.
  - 목요일 2 ~ 8시 사이 예약할시 할인
  - 화요일 2 ~ 8시 사이 예약할시 할인
  - 영화가 1차 순번으로 있는 날은 할인
  - 영화가 10차 순번으로 있는 날은 할인

```ruby
avartar = Movie.new(
  title = "Avartar",
  running_time = "2 시간",
  fee = Money.wons(10000),
  discount_policy = PercentDiscountPolicy.new(
    conditions =[
          PeriodCondition.new("목요일", 2, 8),
          PeriodCondition.new("화요일", 2, 8),
          SequenceCondition.new(1),
          SequenceCondition.new(10)
        ],
    percent = 10
      )
    )
```

- 2000원 할인을 적용시킨 코드이다.
  - 목요일 3 ~ 4시 사이 예약할시 할인
  - 금요일 7 ~ 8시 사이 예약할시 할인
  - 영화가 2차 순번으로 있는 날은 할인
  - 영화가 3차 순번으로 있는 날은 할인

```ruby
avartar = Movie.new(
  title = "Avartar",
  running_time = "2 시간",
  fee = Money.wons(10000),
  discount_policy = AmountDiscountPolicy.new(
    conditions =[
          PeriodCondition.new("목요일", 3, 4),
          PeriodCondition.new("금요일", 7, 8),
          SequenceCondition.new(2),
          SequenceCondition.new(3)
        ],
    discount_amount = 2000
      )
    )
```

위와 같이 짜볼 수 있을 것이다..