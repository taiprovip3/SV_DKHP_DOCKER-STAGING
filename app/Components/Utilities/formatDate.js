export function formatDate(inputDateString) {
  const inputDate = new Date(inputDateString);
  const formattedDateString = inputDate.toLocaleString('en-US', {
    hour: '2-digit',
    minute: '2-digit',
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour12: false,
    timeZone: 'UTC',
  });
  const [formattedDate, formattedTime] = formattedDateString.split(', ');
  const [month, day, year] = formattedDate.split('/');
  const finalFormattedDateString = `${formattedTime}, ${day}/${month}/${year}`;
  return finalFormattedDateString;
}
  