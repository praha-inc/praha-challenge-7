class Person {
  private readonly _name: string;
  private readonly _startWorkingAt: Date;

  constructor(name: string, startWorkingAt: Date) {
      this._name = name;
      this._startWorkingAt = new Date(startWorkingAt.getTime());
  }
  get name(): string {
    return this._name;
  }

  get startWorkingAt(): Date{
    return new Date(this._startWorkingAt.getTime());
  }
}

class Company {
  private readonly people: Person[]
  constructor(people: Person[]) {
      this.people = people;
  }
}

const firstPerson = new Person('a', new Date('2021-01-01'));
const secondPerson = new Person('b', new Date('2021-01-1'));
const company = new Company([firstPerson, secondPerson]);

// 何らかのロジックに使用するため、firstPersonの勤務開始日を取り出す
const date = firstPerson.startWorkingAt;
const personname = firstPerson.name;

// 新しく生成されたDateに対しての更新であるため、もとのPersonのプロパティに対して影響は出ない。
date.setFullYear(1000);
// readonlyであるため、外から直接データを操作できない
// firstPerson.name = 'modified name'

console.log(company);