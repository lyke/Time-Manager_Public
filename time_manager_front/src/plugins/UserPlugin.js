export function isUserManager(role) {
    if (role === "manager" || role === "super_manager") {
        return true;
    }
    return false; 
}

export function isUserSuperManager(role) {
    if (role === "super_manager") {
        return true;
    }
    return false; 
}