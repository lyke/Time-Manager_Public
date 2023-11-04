export function isUserManager(role) {
    if (role === "manager" || role === "super_manager") {
        return true;
    }
    return false; 
}