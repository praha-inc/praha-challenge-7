class ID {
  readonly value: string;
  constructor(value: string) {
    if (!/^[a-zA-Z0-9]+$/.test(value)) {
      throw new Error("IDは英数字のみです。");
    }
    this.value = value;
  }
}

class Name {
  readonly value: string;
  constructor(value: string) {
    if (value.length < 20) {
      throw new Error("Nameは20文字未満である必要があります。");
    }
    this.value = value;
  }
}

class BloodType {
  readonly value: string;
  constructor(value: string) {
    if (!/^(a|b|o|ab)$/i.test(value)) {
      throw new Error("血液型はA,B,O,ABのみです。");
    }
    this.value = value;
  }
}

class Birthday {
  readonly value: Date;
  constructor(value: Date) {
    const age = this.calculateAge(value);
    if (age < 20) {
      throw new Error("生年月日は20歳以上のみです。");
    }
    this.value = new Date(value); // new Dateにする！
  }
  // 年齢を計算する。
  public calculateAge(birthDate: Date): number {
    const today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    const monthDiff = today.getMonth() - birthDate.getMonth();
    if (
      monthDiff < 0 ||
      (monthDiff === 0 && today.getDate() < birthDate.getDate())
    ) {
      age--;
    }

    return age;
  }
}

export class Human {
  readonly ID: ID; // 識別子
  readonly name: Name; // 名前
  readonly bloodType: BloodType; // 血液型
  readonly birthday: Birthday; // 生年月日
  private constructor(
    ID: ID,
    name: Name,
    bloodType: BloodType,
    birthday: Birthday
  ) {
    this.ID = ID;
    this.name = name;
    this.bloodType = bloodType;
    this.birthday = birthday;
  }
  // クラスをimmutableにするためコンストラクタはPrivateでStaticなファクトリーメソッドで生成
  // 普通にコンストラクタでもいいのですが、ファクトリーメソッドだと取り回しがしやすい。
  // 例えばDBから取ってくる値はチェックをしなくて良かったりするのでcreateとrestoreみたいなのを作るのが松岡さん流
  static create(ID: ID, name: Name, bloodType: BloodType, birthday: Birthday) {
    return new Human(ID, name, bloodType, birthday);
  }
}
