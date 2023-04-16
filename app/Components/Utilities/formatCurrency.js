export function formatCurrency(number) {
    // return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(number);
    // return number.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
    return number.toFixed(0).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
}