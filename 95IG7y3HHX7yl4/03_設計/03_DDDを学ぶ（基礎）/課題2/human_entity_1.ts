class Id {
  readonly value: String;
  constructor(value: String) {
    if (value.length == 0) {
      console.log('idは1文字以上の長さにしてください');
      throw Error();
    }
    this.value = value;
  }
}

enum BloodTypeEnum {
  A = "A",
  B = "B",
  AB = "AB",
  O = "O",
}

class BloodType {
  readonly name: String;
  constructor(type: BloodTypeEnum) {
    this.name = type;
  }
}

class BirthData {
  private readonly _value: Date;
  constructor(value: Date) {
    if (value.valueOf() > new Date().valueOf()) {
      throw new Error("未来の日付は設定できません");;
    }
    this._value = value;
  }

  get value(): Date {
    return new Date(this._value.getTime());
  }
}

class Name {
  readonly value: String;
  constructor(value: String) {
    if (value.length == 0) {
      throw new Error("名前は1文字以上の長さにしてください");;
    }
    this.value = value;
  }
}

class HumanEntity {
  private readonly _id: Id;
  private readonly _bloodType: BloodType;
  private readonly _birthDate: BirthData;
  private readonly _name: Name;

  constructor(id: Id, bloodType: BloodType, birthDate: BirthData, name: Name) {
    this._id = id;
    this._bloodType = bloodType;
    this._birthDate = birthDate;
    this._name = name;
  }

  get id(): String {
    return this._id.value;
  }

  get bloodType(): String {
    return this._bloodType.name;
  }

  get birthDate(): Date {
    return this._birthDate.value;
  }

  get name(): String {
    return this._name.value;
  }
}

// 使用例
const human = new HumanEntity(
  new Id('id'),
  new BloodType(BloodTypeEnum.AB),
  new BirthData(new Date()),
  new Name('友輔'),
)
console.log(human.id);
console.log(human.bloodType);
console.log(human.birthDate);
console.log(human.name);