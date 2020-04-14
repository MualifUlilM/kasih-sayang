class Drink{
  int id;
  String imgUrl;
  String name;
  String desc;
  int harga;

  Drink({this.id, this.desc, this.harga, this.imgUrl, this.name});
}

class Drinker{
  static List<Drink> drinks = [
    Drink(
      id: 1,
      name: "King of Ice Tea",
      desc: "Incididunt sunt tempor id excepteur deserunt occaecat est qui quis occaecat Lorem aute quis veniam.",
      harga: 15000,
      imgUrl: 'https://i.pinimg.com/originals/5d/31/ef/5d31ef90cd6c389e07bc48a08e583122.jpg'
    ),
    Drink(
      id: 2,
      name: "Big Bubble",
      desc: "Incididunt sunt tempor id excepteur deserunt occaecat est qui quis occaecat Lorem aute quis veniam.",
      harga: 300000,
      imgUrl: 'https://cdn02.indozone.id/re/content/2019/10/21/0ysMzW/t_5dad81385a02f.jpg?w=700&q=85'
    ),
    Drink(
      id: 3,
      name: "Fresher Mojito",
      desc: "Incididunt sunt tempor id excepteur deserunt occaecat est qui quis occaecat Lorem aute quis veniam.",
      harga: 16000,
      imgUrl: 'https://www.gimmesomeoven.com/wp-content/uploads/2018/05/How-To-Make-A-Mojito-Recipe-Cocktail-Fresh-Honey-3.jpg'
    ),
    Drink(
      id: 4,
      name: "Es Jeruk Kapitalis",
      desc: "Incididunt sunt tempor id excepteur deserunt occaecat est qui quis occaecat Lorem aute quis veniam.",
      harga: 25000,
      imgUrl: 'https://www.cupcakediariesblog.com/wp-content/uploads/2017/01/mai-tai-mocktail-2.jpg'
    ),
    Drink(
      id: 5,
      name: "Es krim Karpet",
      desc: "Incididunt sunt tempor id excepteur deserunt occaecat est qui quis occaecat Lorem aute quis veniam.",
      harga: 15000,
      imgUrl: 'https://www.thegazette.com/storyimage/GA/20180131/ARTICLE/180139949/AR/0/AR-180139949.jpg&MaxH=500&MaxW=900'
    ),
    Drink(
      id: 7,
      name: "The Old School #1",
      desc: "Incididunt sunt tempor id excepteur deserunt occaecat est qui quis occaecat Lorem aute quis veniam.",
      harga: 300000,
      imgUrl: 'https://img-global.cpcdn.com/recipes/fcd39392e38cb3c0/751x532cq70/es-bubur-sumsum-prramadhan_takjil-foto-resep-utama.jpg'
    ),
  ];
}