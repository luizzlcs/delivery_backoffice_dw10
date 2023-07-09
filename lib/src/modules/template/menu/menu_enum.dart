enum Menu {
  paymentType(
    '/payment-type',
    'payment_type_ico.png',
    'payment_type_ico.png',
    'Administrar Formas de Pagamento',
  ),
  products(
    '/products',
    'product_ico.png',
    'product_ico_selected.png',
    'Administrar Produtos',
  ),
  orders(
    '/order',
    'order_ico.png',
    'order_ico_selected.png',
    'Pedidos do dia',
  );

  final String router;
  final String assetIcon;
  final String assetIconSelected;
  final String label;

  const Menu(this.router, this.assetIcon, this.assetIconSelected, this.label);
}
