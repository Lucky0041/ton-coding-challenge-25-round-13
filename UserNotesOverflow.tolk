tolk 1.1

struct Note {
    text: string;
    created: uint32;
}

struct Storage {
    notes: map<address, Note>;
    description: string; // English description
}

fun Storage.load() = Storage.fromCell(contract.getData());
fun Storage.save(self) = contract.setData(self.toCell());

fun addNote(text: string) {
    var st = Storage.load();
    let caller = get_caller();

    st.notes.set(caller, Note{text: text, created: blockchain.now()});
    st.description = "This contract stores user notes in a map, causing storage to grow indefinitely.";
    st.save();
}
