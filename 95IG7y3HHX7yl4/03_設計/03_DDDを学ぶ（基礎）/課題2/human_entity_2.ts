
namespace second {
  class Id {
    readonly value: string;
    constructor(value: string) {
      var reg = new RegExp(/^[0-9a-zA-Z]+$/);
      if (!reg.test(value)) {
        console.log('idは英数字のみ許容');
        throw Error();
      }
      this.value = value;
    }

    public equals(other: Id): boolean {
      return this.value == other.value;
    }
  }

  class BloodType {
    private readonly _requiredTypes: string[] = ['a', 'b', 'o', 'ab'];
    readonly value: string;
    constructor(value: string) {
      if (!this._requiredTypes.includes(value)) {
        console.log(`BloodTypeは、${this._requiredTypes}のどれか`);
      }
      this.value = value;
    }

    public equals(other: BloodType): boolean {
      return this.value == other.value;
    }
  }

  class BirthData {
    private readonly _limitedAge = 20;
    private readonly _value: Date;
    constructor(value: Date) {
      const currentDate = new Date();
      const ageLimitDate = new Date(
        currentDate.getFullYear() - this._limitedAge, 
        currentDate.getMonth(), 
        currentDate.getDate()
      );
      if (value.valueOf() < ageLimitDate.valueOf()) {
        throw new Error("20歳以上の生年月日しか設定できません");;
      }
      this._value = value;
    }

    get value(): Date {
      return new Date(this._value.getTime());
    }

    public equals(other: BirthData): boolean {
      return this.value == other.value;
    }
  }

  class Name {
    private _nameLengthLimit = 20;
    readonly value: string;
    constructor(value: string) {
      if (value.length < this._nameLengthLimit) {
        throw new Error("名前は20文字以下の長さにしてください");;
      }
      this.value = value;
    }

    public equals(other: Name): boolean {
      return this.value == other.value;
    }
  }

  class Human {
    constructor(
      public readonly id: Id,
      public readonly bloodType: BloodType,
      public readonly birthDate: BirthData,
      public readonly name: Name
    ) {}
  }
}
