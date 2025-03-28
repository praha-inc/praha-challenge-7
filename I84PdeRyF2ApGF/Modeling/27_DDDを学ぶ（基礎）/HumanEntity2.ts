// ↓修正前のコード
// class Human {
//     constructor(public readonly id: string, public readonly bloodtype: string, public readonly birthdate: Date, public readonly name: string) {
//         if (!this.validProps({id,bloodtype,birthdate,name})) { throw new Error('invalid prop') }
//     }

//     private validProps(props: {id: string, bloodtype: string, birthdate: Date, name: string}): boolean {
//         return this.validId(props.id) && this.validBloodtype(props.bloodtype) && this.validBirthdate(props.birthdate) && this.validName(props.name)
//     }
//     private validId(value: string):boolean { /* 有効なIDである事のバリデーションを行う */ return true }
//     private validBloodtype(value: string):boolean { /* 有効な血液型である事のバリデーションを行う */ return true }
//     private validBirthdate(birthdate: Date):boolean { /* 有効な生年月日である事のバリデーションを行う */ return true }
//     private validName(name: string):boolean { /* 有効な名前である事のバリデーションを行う */ return true }
// }

// ↓修正後のコード
namespace HumanEntity2 {

    /**
     * Humanエンティティ
     */
    class Human {
        private readonly id: HumanId;
        private readonly bloodType: BloodType;
        private readonly birthDate: BirthDate;
        private readonly name: Name;

        constructor(id: HumanId, bloodType: BloodType, birthDate: BirthDate, name: Name){
            this.id = id;
            this.bloodType = bloodType;
            this.birthDate = birthDate;
            this.name = name;
        }

        public equals(other: Human): boolean {
            return this.id === other.id;
        }
    }


    // 以下、値オブジェクト

    class HumanId {
        private readonly value: string;

        constructor(value: string){
            if(value.length === 0){
                throw new Error("IDは必須です")
            }
            if(!this.validate(value)){
                throw new Error("英数字のみ許容です")
            }
            this.value = value;
        }

        private validate(value: string) :boolean {
            return /^[0-9a-z]+$/.test(value);
        }
    }

    class BloodType {
        private static readonly ALLOWED_BLOOD_TYPES = ["a", "b", "ab", "o"];
        private readonly value: string;

        constructor(value: string) {
            if(!BloodType.ALLOWED_BLOOD_TYPES.includes(value)){
                throw new Error("無効な血液型です");
            }
            this.value = value;
        }
    }

    class BirthDate{
        private readonly year: number;
        private readonly month: number;
        private readonly day: number;

        constructor(year: number, month: number, day: number){
            if(!this.validate(year, month, day)){
                throw new Error("無効な日付です");
            }
            if(!this.validateAge(year, month, day)){
                throw new Error("20歳未満の方は登録できません");
            }
            this.year = year;
            this.month = month;
            this.day = day;
        }

        private validate(year: number, month: number, day: number): boolean {
            const date = new Date(year, month - 1, day);
            return date.getFullYear() === year && date.getMonth() === month - 1 && date.getDate() === day;
        }

        private validateAge(year: number, month: number, day: number): boolean {
            const date = new Date(year, month - 1, day);
            const now = new Date();
            let age = now.getFullYear() - date.getFullYear();
            if(now.getMonth() < date.getMonth() || (now.getMonth() === date.getMonth() && now.getDate() < date.getDate())){
                age--;
            };
            return age >= 20;
        }
    }

    class Name {
        private readonly value: string;

        constructor(value: string){
            if(value.length === 0){
                throw new Error("名前は必須です");
            }
            if(!this.validateLength(value)){
                throw new Error("名前は20文字以内です");
            }
            this.value = value;
        }

        private validateLength(value: string): boolean {
            return value.length < 20;
        }
    }

    // 使用例
    const humanId = new HumanId("1234567890");
    const bloodType = new BloodType("a");
    const birthDate = new BirthDate(2000, 1, 1);
    const name = new Name("山田太郎");
    const human: Human = new Human(humanId, bloodType, birthDate, name);
    console.log(human);
}