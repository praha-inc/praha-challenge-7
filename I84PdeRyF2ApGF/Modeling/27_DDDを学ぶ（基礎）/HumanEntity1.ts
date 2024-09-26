namespace HumanEntity1 {
    // Humanエンティティ
    class Human{
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

    // 値オブジェクト
    class HumanId {
        private readonly value: string;

        constructor(value: string){
            if(value.length === 0){
                throw new Error("IDは必須です")
            }
            this.value = value;
        }
    }

    class BloodType {
        private static readonly ALLOWED_BLOOD_TYPES = ["A", "B", "AB", "O"];

        private readonly value: string;

        constructor(value: string) {
            if(!BloodType.ALLOWED_BLOOD_TYPES.includes(value)){
                throw new Error("無効な血液型です");
            }
            this.value = value;
        }
    }

    class BirthDate {
        private readonly year: number;
        private readonly month: number;
        private readonly day: number;

        constructor(year: number, month: number, day: number){
            if(this.validate(year, month, day)){
                throw new Error("無効な日付です");
            }
            this.year = year;
            this.month = month;
            this.day = day;
        }

        private validate(year: number, month: number, day: number): boolean {
            const date = new Date(year, month - 1, day);
            return date.getFullYear() === year && date.getMonth() === month - 1 && date.getDate() === day;
        }

        public toString(): string {
            return `${this.year}/${this.month}/${this.day}`;
        }
    }

    class Name {
        private readonly value: string;

        constructor(value: string){
            if(value.length === 0){
                throw new Error("名前は必須です");
            }
            this.value = value;
        }
    }


    const humanId: HumanId = new HumanId("1");
    const bloodType: BloodType = new BloodType("A");
    const birthDate: BirthDate = new BirthDate(1995, 7, 31);
    const humanName: Name = new Name("Kenta");

    const human: Human = new Human(humanId, bloodType, birthDate, humanName);

}