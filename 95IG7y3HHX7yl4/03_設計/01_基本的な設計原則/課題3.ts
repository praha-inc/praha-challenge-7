class Person {
  public name: string
  public starWorkingAt: Date
  constructor(name: string, startWorkingAt: Date) {
      this.name = name
      this.starWorkingAt = startWorkingAt
  }
}

class Company {
  public people: Person[]
  constructor(people: Person[]) {
      this.people = people
  }
}

const company = new Company([new Person('a', new Date('2021-01-01')), new Person('b', new Date('2021-01-1'))])
const firstPerson = company.people[0]

// 何らかのロジックに使用するため、Person Aの勤務開始日を取り出す
const date = firstPerson.starWorkingAt

// さまざまなロジックで使用しているなかで誤って更新してしまう
date.setFullYear(1000)
firstPerson.name = 'modified name'

console.log(company) // companyの中に含まれていたPerson Aの勤務開始日が変わってしまう！
