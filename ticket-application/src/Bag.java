public class Bag {

    private Long amount;
    private Invitation invitation;
    private Ticket ticket;

    // 초대장을 받지 않은 관람객의 가방
    public Bag(Long amount) {
        this(null, amount);
    }

    // 초대장을 받은 관람객의 가방
    public Bag(Invitation invitation, Long amount) {
        this.invitation = invitation;
        this.amount = amount;
    }

    public boolean hasInvitation() {
        return invitation != null;
    }

    public boolean hasTicket() {
        return ticket != null;
    }

    public void setTicket(Ticket ticket) {
        this.ticket = ticket;
    }

    public void setInvitation(Invitation invitation) {
        this.invitation = invitation;
    }

    public void plusAmount(Long amount) {
        this.amount += amount;
    }

    public void minusAmount(Long amount) {
        this.amount -= amount;
    }

}
