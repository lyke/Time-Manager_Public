export function getCurrentTime() {
    var date = new Date();
    const year = date.getFullYear();
    const month = date.getMonth() + 1;
    const day = date.getDate();
    const formattedDay = day < 10 ? '0' + day : day;
    const hours = date.getHours();
    const formattedHours = hours < 10 ? '0' + hours : hours;
    const minutes = date.getMinutes();
    const formattedMinutes = minutes < 10 ? '0' + minutes : minutes;

    return year + "-" + month + "-" + formattedDay + "T" + formattedHours + ":" + formattedMinutes;
}