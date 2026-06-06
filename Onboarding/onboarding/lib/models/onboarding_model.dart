class OnboardingModel {
  final String imagePath;
  final String title;
  final String description;

  OnboardingModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  // Khởi tạo danh sách dữ liệu tĩnh trực tiếp trong Model
  static List<OnboardingModel> getPages() {
    return [
      OnboardingModel(
        imagePath: 'https://www.magnific.com/vn/hinh-chup-mien-phi/hai-vo-si-co-bap-dang-thi-dau-tren-vo-dai-ho-doi-mu-bao-hiem-va-deo-gang-tay_25131009.htm#fromView=keyword&page=1&position=1&uuid=0c06a3d6-f4d5-4dc2-8b84-236453364cb5&query=Boxing',
        title: 'Tính Năng 1',
        description: 'abcd',
      ),
      OnboardingModel(
        imagePath: 'https://www.google.com/imgres?q=%E1%BA%A3nh%20boxing&imgurl=https%3A%2F%2Fimages.pexels.com%2Fphotos%2F30722608%2Fpexels-photo-30722608%2Ffree-photo-of-tr-n-d-u-quy-n-anh.jpeg&imgrefurl=https%3A%2F%2Fwww.pexels.com%2Fvi-vn%2Ftim-kiem%2Fboxing%2F&docid=FzGSwMlLwUCM-M&tbnid=-WKGU33TEgIR4M&vet=12ahUKEwi7_L6riPOUAxUecPUHHXWYIa8QnPAOegQIKhAB..i&w=3480&h=2486&hcb=2&ved=2ahUKEwi7_L6riPOUAxUecPUHHXWYIa8QnPAOegQIKhAB',
        title: 'Giới Thiệu 2',
        description: 'xyz',
      ),
      OnboardingModel(
        imagePath: 'e:\Dmitry Bivol 🥊.jpg',
        title: 'Kết Nối Dễ Dàng',
        description: 'kkkkkkkk',
      ),
    ];
  }
}