

export class Person {
  private name: string = "";

    public getName(): string {
        return this.name;        
    }

    public setName(name: string): string {
        return this.name = name;       
    }

}
